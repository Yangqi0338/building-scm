package com.newzkl.platform.app.scm;

import com.dtflys.forest.springboot.annotation.ForestScan;
import com.newzkl.platform.base.common.core.job.infrastructure.annotation.EnableXXLJob;
import com.newzkl.platform.base.common.core.mq.infrastructure.annotation.EnableMQConfiguration;
import org.dromara.autotable.springboot.EnableAutoTable;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.context.config.annotation.RefreshScope;

/**
 * SCM 后端入口启动类。
 *
 * <p>聚合 Base 业务 action 与已装配的身份 plugin; 扫描 {@code com.newzkl.platform} 覆盖 base 业务、
 * SPI 基建与 plugin 实现。装配哪些 plugin 由本模块依赖决定, 即部署级身份能力开关。</p>
 *
 * @author KC
 */
@ForestScan(basePackages = {"com.newzkl.platform"})
@EnableXXLJob
@RefreshScope
@EnableCaching
@EnableAutoTable
@EnableMQConfiguration
@SpringBootApplication(scanBasePackages = "com.newzkl.platform")
@MapperScan({"com.newzkl.platform.**.infrastructure.**.dao.**","com.newzkl.platform.**.infrastructure.dao.**", "com.newzkl.platform.base.common.**.infrastructure.**.dao.**","com.newzkl.platform.base.common.**.**.infrastructure.**.dao.**"})
public class ScmApplication {

    /**
     * 启动入口。
     *
     * @param args 启动参数
     */
    public static void main(String[] args) {
        SpringApplication.run(ScmApplication.class, args);
    }
}
