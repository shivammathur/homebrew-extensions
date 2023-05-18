# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "43e382bc2195cfc44436ed9fa1e6fea9360e243fc320b4c61803a18ac8f5994e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1920aede3e7c35ed95ca1f9de71560b97a468dcacc9bb25c3c782803fc175a5e"
    sha256 cellar: :any_skip_relocation, ventura:        "561d935b63aaa0ad998bc206d69209cff3afa15ba62f98ab2f154a5309712cee"
    sha256 cellar: :any_skip_relocation, monterey:       "1dd381c09dc96d689a5f1a39d7b10970b9e191185e59bb173e9447d37bf49527"
    sha256 cellar: :any_skip_relocation, big_sur:        "bc0108a71a29f56eb9066030ffd7c9c2bb2d1c8ea43ac5cca0b1450b5bb0ffbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8fe3b0a9ab817a60e9c5a19fb2bd4984a46ec028bd8e10c935e8571064c762d"
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
