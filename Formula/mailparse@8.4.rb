# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a6882249c1af14e0750acdf2f9fb8179f0f821105e88431a1d1e8a0f523e2bbf"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4a51b3ab57a80db9a4d2085607f8cc4a286d10dddebe14ce889c6e6f6070b637"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1e4231557f433407aa4f0dd1fd81c509da657f6537f8b9e8fd8aeddfec5d6abe"
    sha256 cellar: :any_skip_relocation, ventura:        "9f2b0ea936b923fbbc58286b02da00347b65a67c080e6a10694b37fdf7770ed4"
    sha256 cellar: :any_skip_relocation, monterey:       "9f8c7766e76240527ddb65ae7b05c1154386d09abafbeea511a661a8d43130f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60ef210923de77792b3bc4bd5652c016f3b29052c841e32e1f90de68b485ff82"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
