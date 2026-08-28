package com.newzkl.platform.app.scm.config;

import com.fasterxml.jackson.databind.module.SimpleModule;
import com.newzkl.platform.base.common.core.model.enums.EnumDeserializerModifier;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 全局枚举反序列化装配
 *
 * <p>非侵入注册 (走 {@link Jackson2ObjectMapperBuilderCustomizer}, 不覆盖 Spring Boot 默认消息转换器)。
 * 前端传入的枚举 code (字符串或数字) 按字段值匹配枚举常量, 越界或未知值反序列化为 {@code null},
 * 不再抛 {@code JsonParseException}, 由 validation 层控制合法性</p>
 *
 * @author KC
 */
@Configuration
public class EnumDeserializeConfig {

    /**
     * 注册枚举反序列化修饰器到全局 ObjectMapper
     *
     * @return Jackson builder 定制器
     */
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer enumDeserializeCustomizer() {
        return builder -> {
            SimpleModule module = new SimpleModule();
            module.setDeserializerModifier(new EnumDeserializerModifier());
            builder.modulesToInstall(module);
        };
    }
}
