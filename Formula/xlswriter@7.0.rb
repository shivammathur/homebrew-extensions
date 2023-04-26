# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.4.tgz"
  sha256 "6df4198ac50366317bbecdfd08d34047cff517465be48261849f50b833da0b73"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3980725377cb35fbdf67a102bb5b3c5429b19fc7140d2f80238fcf424be85033"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7531c9eca78766949798775fd1e05f545cc9553a12e7d83f2dd51721a0ef4201"
    sha256 cellar: :any_skip_relocation, ventura:        "00191648a87573287aeedca3559f71013cfef8c1a6c981b7e08331ea95577452"
    sha256 cellar: :any_skip_relocation, monterey:       "738633f7d97f3f836488dc62fdfe8d24bdd70cd31648d313cd89c928a69a535a"
    sha256 cellar: :any_skip_relocation, big_sur:        "5e342b28baa4b31a0febb3d6dfe39334f9d7faede3b33b561a5113047664ed22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8f0ff698a0aa2b32869eebbcb450661289df4cd7892dbb140060829663a9914"
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
