package com.newzkl.platform.app.scm;

import com.newzkl.platform.base.common.core.model.constants.TokenConstants;
import com.newzkl.platform.base.common.core.model.exception.PlatformException;
import com.newzkl.platform.base.common.core.utils.spring.SecurityContextHolder;
import com.newzkl.platform.base.common.ddd.action.spi.IdentityDispatcher;
import com.newzkl.platform.base.common.ddd.action.spi.IdentityExtensionProxyRegistrar;
import com.newzkl.platform.base.common.ddd.action.spi.IdentityExtensionRegistrar;
import com.newzkl.platform.base.common.ddd.application.spi.IdentityImpl;
import com.newzkl.platform.base.common.ddd.application.spi.demo.IdentityConfigExt;
import com.newzkl.platform.base.common.ddd.model.enums.RoleEnum;
import com.newzkl.platform.plugin.channel.config.ChannelConfigProvider;
import com.newzkl.platform.plugin.supplier.config.SupplierConfigProvider;
import com.newzkl.platform.app.scm.config.DefaultConfigProvider;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * 身份配置扩展点分发装配验证 (零 DB, {@link ApplicationContextRunner} 不启全容器)。
 *
 * <p>覆盖三场景: 全装身份命中 / 缺 supplier 无匹配报错 / 条件重叠启动失败。演示扩展点 {@link IdentityConfigExt}
 * 纯内存实现, 不触碰数据库。</p>
 *
 * @author KC
 */
class IdentityConfigDispatchTest {

    /** SPI 基建 (dispatcher/registrar/proxyRegistrar) 装配。 */
    private final ApplicationContextRunner runner = new ApplicationContextRunner()
            .withUserConfiguration(InfraConfig.class);

    @AfterEach
    void clear() {
        SecurityContextHolder.remove();
    }

    /**
     * 场景A 全装: Default(1,2)+Channel(1002)+Supplier(1001) 均在, 各身份精确命中。
     */
    @Test
    void allInstalledResolvesEachIdentity() {
        runner.withBean(DefaultConfigProvider.class)
                .withBean(ChannelConfigProvider.class)
                .withBean(SupplierConfigProvider.class)
                .run(ctx -> {
                    IdentityDispatcher dispatcher = ctx.getBean(IdentityDispatcher.class);
                    IdentityConfigExt ext = dispatcher.resolve(IdentityConfigExt.class);

                    SecurityContextHolder.set(TokenConstants.DETAILS_ROLE, "1002");
                    assertThat(ext.config("x")).isEqualTo("channel:x");

                    SecurityContextHolder.set(TokenConstants.DETAILS_ROLE, "1001");
                    assertThat(ext.config("x")).isEqualTo("supplier:x");

                    SecurityContextHolder.set(TokenConstants.DETAILS_ROLE, "1");
                    assertThat(ext.config("x")).isEqualTo("platform:x");
                });
    }

    /**
     * 场景B 无 supplier: 仅 Default+Channel, 身份 1001 无匹配且 default 非兜底 →。
     */
    @Test
    void missingSupplierThrowsForUnmatchedIdentity() {
        runner.withBean(DefaultConfigProvider.class)
                .withBean(ChannelConfigProvider.class)
                .run(ctx -> {
                    IdentityDispatcher dispatcher = ctx.getBean(IdentityDispatcher.class);
                    IdentityConfigExt ext = dispatcher.resolve(IdentityConfigExt.class);

                    SecurityContextHolder.set(TokenConstants.DETAILS_ROLE, "1001");
                    assertThatThrownBy(() -> ext.config("x"))
                            .isInstanceOf(PlatformException.class);
                });
    }

    /**
     * 场景C 负向重叠: 追加第二个 {@code @IdentityImpl(1002L)} 与 Channel 冲突 → 启动期两两不相交校验失败, 上下文启动失败。
     */
    @Test
    void overlappingConditionFailsContextStartup() {
        runner.withBean(DefaultConfigProvider.class)
                .withBean(ChannelConfigProvider.class)
                .withBean(CollidingChannelConfigProvider.class)
                .run(ctx -> assertThat(ctx).hasFailed());
    }

    /**
     * 与 {@link ChannelConfigProvider} 条件重叠 (同为 1002) 的冲突实现, 仅用于场景C 触发 fail-fast。
     */
    @IdentityImpl(RoleEnum.CompanyRole.CHANNEL)
    static class CollidingChannelConfigProvider implements IdentityConfigExt {

        @Override
        public String config(String key) {
            return "collide:" + key;
        }
    }

    /**
     * SPI 基建配置: 分发器 + 注册器 + 透明代理注册器。
     */
    @Configuration
    static class InfraConfig {

        /**
         * @return 身份分发器
         */
        @Bean
        IdentityDispatcher identityDispatcher() {
            return new IdentityDispatcher();
        }

        /**
         * @param dispatcher 分发器
         * @return 启动期收集 + 两两不相交校验注册器
         */
        @Bean
        IdentityExtensionRegistrar identityExtensionRegistrar(IdentityDispatcher dispatcher) {
            return new IdentityExtensionRegistrar(dispatcher);
        }

        /**
         * @return 透明代理注册器 (BeanDefinitionRegistryPostProcessor 需 static)
         */
        @Bean
        static IdentityExtensionProxyRegistrar identityExtensionProxyRegistrar() {
            return new IdentityExtensionProxyRegistrar();
        }
    }
}
