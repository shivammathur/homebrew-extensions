# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e605cb6b37dd33780f30078962ec08584cef344e4b53ccccc49604a4eb355d94"
    sha256 cellar: :any_skip_relocation, big_sur:       "5352aeaf761bd685407306b6daa238c8bcf21d53bc6769404abc61c9a4c54152"
    sha256 cellar: :any_skip_relocation, catalina:      "996198e419767dc20d11cb82344b91dcd4e5d050bbf350d6fb59e9d569abb6ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9fd98835787b2e7cb141ed1472cdf2522771ccab185d26eed114f0578ac488b"
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
