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

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bbcb30ede521969a8e4b04d72d9aa3c2acaade3ae88a8af21a2d45b27d1c0db4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0df1559794ca2565f77b2f2596f2f69c24c23b0592d3c478c313c1c8b0837850"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "45c059e96366d699866a7e0c4912019eb18053076b9012dd1f778c714d269963"
    sha256 cellar: :any_skip_relocation, ventura:       "cb5f17eda15120ead258c3213272eb932a44dcb849e6b3954929cdf554965eb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e78155f56cd2b68fb52776700c9715304c440b490c4746d30775608a4b5d4360"
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
