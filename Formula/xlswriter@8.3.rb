# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "60aa48715e28d6adac026c7b5e4711a994c64da10863ba4cea2402c728b79da7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7f61648b1e0680e89fccbf1c27c28ab129b5313a4161636acc31f3737951d5af"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "df86b13ec25e52ae73015c94f60520fa813adeadc53babadeedb9f76ecf1bd0b"
    sha256 cellar: :any_skip_relocation, sonoma:        "7bc158bae46e9475748676b5cb071375763ad9e2ac2080040bdc6cd982894e2f"
    sha256 cellar: :any,                 arm64_linux:   "261072a0923aa51c90caac98106049c2d187eceedb698ae855d4f9d20e7f258b"
    sha256 cellar: :any,                 x86_64_linux:  "b103df038ffb2af183eb9c429583802ed238986fe59024b7f88855b91413a91c"
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
