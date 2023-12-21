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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "dd6641e1a96c623bafee1e8f15d8209cb0fcb132405c081cb79ecb14e013bfeb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5bcda6fc0d66f9f13255906759f6ef69e9b9647fafaeec5f961a79a0f6f2716c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8c6df9c242b2cf7485950ce1de1893bce07a32a2c71f5232ea136a2169f34c66"
    sha256 cellar: :any_skip_relocation, ventura:        "c5a83f58460bd9d37e53c34d8035d9f11f8c090634ca791d2534711d6fa0e436"
    sha256 cellar: :any_skip_relocation, monterey:       "02a338dbb894dfb9bbb92c660a8672fb7f569020a06230ef5f9b914ab522d499"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0f3b13461acac6ed93f32b4b173c78aa9324f42e2eb7a36ae90fca02b418c65"
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
