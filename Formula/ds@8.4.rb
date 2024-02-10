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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "efdadf0b7df6344605a41eb508d62eb22d3ce12bfa6c3dac0991de0a077612e4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1585048165bde333a4c08e7b7e0f020b34d582b689849bf0ab2fb0879b8c5a69"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0e8fef927d0bd8f4618c0428e7ab91b844ea19630eed2c2bb0a44847cb99452a"
    sha256 cellar: :any_skip_relocation, ventura:        "79622359a5dc5ef2691ac23c88b853db01bdd6a4d6302ec89843957217726b00"
    sha256 cellar: :any_skip_relocation, monterey:       "8ca6f5a98c7e9c4b13853d1372f8e76322b193febf83a58d51be71c2a212bbcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "36344116297dbd4060a4045831e9f6cb3589a472193ba4f21619382dd119bf04"
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
