# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9c9a7714df66b4f0131f6dc4dc5175433226d1376db20fe9dc3926bcdb3f6b2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dc10a425bde38ecca2c8df5f1f911f108520e8587a71c2ee8696b66939013e31"
    sha256 cellar: :any_skip_relocation, ventura:        "6faa641033c04475a6971a5709a371db9de8d53a66cbf319067b79a55269083b"
    sha256 cellar: :any_skip_relocation, monterey:       "932a155bcf54cac0b5ecd966a9c212fce46b1afc386e58ee5ab2941d03f74779"
    sha256 cellar: :any_skip_relocation, big_sur:        "6b6d98b7dfb0d0258f9a390cac03b380235bf97f5b44ecde2effbf1b973a84d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39da1c139f0060e25051610995dc5fae577ee8baebec9397f4152950312d5d62"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
