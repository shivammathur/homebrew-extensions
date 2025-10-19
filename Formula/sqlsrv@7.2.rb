# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT72 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.9.0.tgz"
  sha256 "0a108e0408e8b984e5ae8bc52824ed32872d72e3a571cd2a5d2b63b200215ab3"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "931fd64bf2e36d44403162cfa2b12aeb1d01566c80ef3db80fc3d91493b9fd2d"
    sha256 cellar: :any,                 arm64_ventura:  "c01c3290a479ef533bd3ffd4478a501d93e7d41f84dea7f674e89a2de8f6a2be"
    sha256 cellar: :any,                 arm64_monterey: "7cd2bd68dc8c6ec66ba2eea8f11b909735c9541df901ea40228342a5bcc94ca5"
    sha256 cellar: :any,                 arm64_big_sur:  "e8b07d6500f01138ae7eb653dd4090a671dd7824d3cb8dc2c1ef0d9ae3489770"
    sha256 cellar: :any,                 sonoma:         "552e4a577dd4bd627d1410738ba3b4aec817214bee0599883b2ce57b62fd9d69"
    sha256 cellar: :any,                 ventura:        "29a13ef06d117d7c15aa9a2fafd89b49bf8a97f81ab0c6a10a8391bf1b28ae05"
    sha256 cellar: :any,                 monterey:       "81259ea8536efc8a608d8e89ae0ce8d70354ac7cdeef90aed15cf3701513f556"
    sha256 cellar: :any,                 big_sur:        "0a0bfcf787a2307d5330aa530c544e2a0d1419f2757e004f76f6be65a253dd00"
    sha256 cellar: :any,                 catalina:       "da41006ca751d497869f1f7f3f31ec5100cbc10667bde3b1164403f74341a8f6"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "949b61bcd913ad2f9662231e8c190be3573fcf4438c4c33267221f45fd6d174c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e33382550dcf535513ab0cc7b61e90438b0e7f1129ee0f83a84d8e436cbb852d"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
