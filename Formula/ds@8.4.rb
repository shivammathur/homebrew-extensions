# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cdf317b9f58e8ae8a0e90f375425ae6b0f13d3c713e8e4a0a531dba2ae73fe7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e7ac5e0004eff2f187713d3a7c9c8d7708e2883ba47c656e11da2a955286e710"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "25401b878ca65e194331f2582327d79a73ec339a8500328684e927fb6899d4e9"
    sha256 cellar: :any_skip_relocation, ventura:        "923423f404d8a5cd5a2887f671f80867b60e49d5a77d41f1c7fe4d7a956fd150"
    sha256 cellar: :any_skip_relocation, monterey:       "d3a650e0edcda01f5928f2653d6412dca618b9ef7cc92e9ba4de3f05d30fafce"
    sha256 cellar: :any_skip_relocation, big_sur:        "e3ee64e69c690319fc2e58ad8f49418e8d293ad9cb64cde58fbe437dfbcb5781"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5852512e75d0ab7d6f1e632e452a388be654ecd33345decc0ce243e15c68f28"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
