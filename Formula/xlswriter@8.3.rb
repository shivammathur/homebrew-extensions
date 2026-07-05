# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "68e18938f1233081998ec1cfb720071549ee23cfc7988dfdeab4bf278feb960a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5d9ecec084dd5582ae6b647e226e929a86d37f52635566d03e6638a86138294e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e53d84938ac5117b980b6aa291f7e65d0405fc3a66572851f299d9a6ae6268d"
    sha256 cellar: :any_skip_relocation, sonoma:        "72878ca3f1063e76020662b385738ae523ff23f109e38aee15cc29b79dbbec20"
    sha256 cellar: :any,                 arm64_linux:   "beade5ff8c7f9b6bfd8a166025c81ab5db0ef94591882e2dda2d8e94bae12336"
    sha256 cellar: :any,                 x86_64_linux:  "d1e302258cad7ad2801718248156004d74711843ce3bfdddb3836f748a5893f6"
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
