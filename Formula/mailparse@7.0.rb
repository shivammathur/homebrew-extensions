# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6a7ec600f53fdee507e7909195b7d5b5268e9b481666a9ad099b08f476e70f8e"
    sha256 cellar: :any_skip_relocation, big_sur:       "16b48453dc97df15fa6cc20501d2988a2741774418d63dd7bb0686084c305609"
    sha256 cellar: :any_skip_relocation, catalina:      "d804e57e0b33e639ccb07eecc4a5450f830c1f0a0d40a43eb78e2918aef66e2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8160d1c9a687b822ff61d215bcde6b9336c4e388aca4247c4b2e554f6c53f1ca"
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
