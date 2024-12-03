# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a288329284fd394dfceaef6043f887f24656e349db6893a547d51c7c14a058e8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4b45e12f6664341ced1ca387fc75feb7d2b931867f1b015a3ae2c86eee632a19"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fbb92d88cc0ff13dc63031360fe9862e2ea7498a814728e96541110b680f5a75"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "878beb1247dce633c2df5b8f4f209dbfb0c7c5800bbe44ac5bf8965eba7e5aed"
    sha256 cellar: :any_skip_relocation, ventura:        "14d37fea411f2f70f046e266924c221be0380cc1590023d1d9156e5ebc766b3e"
    sha256 cellar: :any_skip_relocation, monterey:       "9a4240f23a65b0d31b788a8406d7e7d8897efa345d56ef67340049623385d34e"
    sha256 cellar: :any_skip_relocation, big_sur:        "2e688308a702432588fef5bdf29e2762d2e2621659a89c03b8e957cdf1c6537f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27a6e714588e7b6dffe197586a92ab0b186e46107d7fd65b0f5be54e48d9ff2e"
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
