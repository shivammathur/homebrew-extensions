# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT82 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "934a6ddd7947cb729d545bf211cb25ef6e895322593fec2e60657b102bf16f45"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "636ebe387367984d58f6f11173f0c1f993088f1b57665b04b950a19b39235d09"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d804036b15611f3ad760f2d25bd6fb3c1ae8d79d4a76a0b50f1fafcee418a2e8"
    sha256 cellar: :any_skip_relocation, ventura:        "5a9ed07573da343aae14edd08ffe9d04d9f72f2eb3907f16cecd9e0fc2fd9428"
    sha256 cellar: :any_skip_relocation, monterey:       "ef5417c4363626ea5c8e784d22e541b95a95a28e0f5647169dfbef2b1ad62d04"
    sha256 cellar: :any_skip_relocation, big_sur:        "0db260af0256541d0a89d7db560cac401794a8c5765555bf7897e90fc215f051"
    sha256 cellar: :any_skip_relocation, catalina:       "70bf6eb18c7849d6fa51efeb9b5cb9fe000355c57866862247927b8f49fcf419"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cca4eef7f9a761e07115b040e4c55d29570fd7e14fe9d74151a9cdc9921e9db7"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
