# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.2.tgz"
  sha256 "b0647ab07ea480fcc13533368e38fdb4f4bb45d30dce65fc90652a670a4f4010"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bcc2ca18aa778a2f9757bd26aca003dcbbce59fffdd54eefe97687d2cbcb608f"
    sha256 cellar: :any_skip_relocation, big_sur:       "8eeccef4093fc11ebc2ffde2e710f849f18d69419c344e6965389b784c580ea6"
    sha256 cellar: :any_skip_relocation, catalina:      "2abae38b4b7748491fd6f1b69acc9898de21ec6376f042a93e6f247f519756f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d138027e2ef93723fc5cddbd5d520fecef277fba454b72e6167bb895142f552"
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
