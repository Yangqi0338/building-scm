package com.newzkl.platform.app.scm.config;

import com.newzkl.platform.base.common.ddd.application.spi.IdentityImpl;
import com.newzkl.platform.base.common.ddd.application.spi.demo.IdentityConfigExt;
import com.newzkl.platform.base.common.ddd.model.enums.RoleEnum;

/**
 * 身份配置提供-平台默认实现(演示)。
 *
 * <p>命中平台管理员 (PLATFORM) 与平台员工 (EMP) 身份, 返回带平台标识的配置值; 条件非空 (非 catch-all),
 * 故未装配对应 plugin 的其它身份无命中而被拒绝。纯内存零依赖, 用于验证身份 SPI 分发。</p>
 *
 * @author KC
 */
@IdentityImpl({RoleEnum.CompanyRole.PLATFORM, RoleEnum.CompanyRole.EMP})
public class DefaultConfigProvider implements IdentityConfigExt {

    @Override
    public String config(String key) {
        return "platform:" + key;
    }
}
