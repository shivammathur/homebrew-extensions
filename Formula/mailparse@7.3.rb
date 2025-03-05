# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "99ab8ea45faaf2b1bdfc6095bc154a01148c0460531b7b53aa03220a75c50664"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7121e71870df0b1694d11acf4633d83fe7f07fdba5a8baef3454562e88724d46"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f297fbebe8263a85d576837992d107c7bf29c3eab2d1724dcdb86170ba3a0214"
    sha256 cellar: :any_skip_relocation, ventura:       "a4c08c49ee71e8a2d6a27aef84ca62b521318e2caa45396aa8617e8743f45e4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "126a0725d7b0e4763ed8a33a0a778b3cef170f711ba1012d380a8714c223dea1"
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
