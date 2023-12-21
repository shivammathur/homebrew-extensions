# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dcccca9acebcd738ba9c728e94f577eb1a38fc8a754b9f77efa835508dff34ce"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "09599acc055dfdc8ab489733b839aeb466ab4777225548519323edd392920947"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9269cb11a5b1a9fe1dbb206781c2aec084f771af33f47f39aa14fdb746643e20"
    sha256 cellar: :any_skip_relocation, ventura:        "6ef7c7598f0b144415ba454790d6d5dce65ca95ad8b4a314aec28d8d5cc262e9"
    sha256 cellar: :any_skip_relocation, monterey:       "6397789f067ba4a4f32cfd70c6238fccb2444eff3b46fb529a23fb125f838090"
    sha256 cellar: :any_skip_relocation, big_sur:        "b82ce3335160ff57a915e64db933ab83519f3c6c4951b5a360a911bbc8b7b918"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b855b2f115cef1f2e29f77a651a9b0c95d74e19f2980dca891de4d53ea7d2f86"
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
