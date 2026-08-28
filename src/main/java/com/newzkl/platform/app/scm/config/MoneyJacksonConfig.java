package com.newzkl.platform.app.scm.config;

import com.fasterxml.jackson.databind.module.SimpleModule;
import com.newzkl.platform.base.common.core.model.money.Money;
import com.newzkl.platform.base.common.core.model.money.MoneyJsonDeserializer;
import com.newzkl.platform.base.common.core.model.money.MoneyJsonSerializer;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 全局 Money 序列化装配
 *
 * <p>非侵入注册 (走 {@link Jackson2ObjectMapperBuilderCustomizer}, 不覆盖 Spring Boot 默认消息转换器)。
 * 序列化输出元为单位两位小数字符串 (如 {@code "11.11"}), 避免 JS Number 精度丢失与 Money 内部结构外泄;
 * 反序列化接受字符串/数字, 空/null 归一为 Money NULL sentinel。
 * {@link MoneyJsonSerializer}/{@link MoneyJsonDeserializer} 早已存在, 此前未接线, 出参回落 Jackson
 * 默认反射输出 {@code {cent,amount,currency...}} 对象, 本类补齐全局装配</p>
 *
 * @author KC
 */
@Configuration
public class MoneyJacksonConfig {

    /**
     * 注册 Money 序列化/反序列化器到全局 ObjectMapper
     *
     * @return Jackson builder 定制器
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer moneyJacksonCustomizer() {
        return builder -> {
            SimpleModule module = new SimpleModule();
            module.addSerializer(Money.class, new MoneyJsonSerializer());
            module.addDeserializer(Money.class, new MoneyJsonDeserializer());
            builder.modulesToInstall(module);
        };
    }
}
