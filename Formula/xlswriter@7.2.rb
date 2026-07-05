# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "59507704f866d23caa5ab7a06cf544079afe183e327a48a400398330bedc8272"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b631324843b6b9c98cb0f23ba7cb7b5c42b3b2d38f4a5032216a61ddff685240"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6019f26e5b79fd695f98054b1cd95f6d8076c1b09b4459732401a0949b845c80"
    sha256 cellar: :any_skip_relocation, sonoma:        "6204ece8ee47e56478c751cca4d04da27b993a43b7f63b0bd770f56f48d291bb"
    sha256 cellar: :any,                 arm64_linux:   "0744aff2ed76eddd06ade0931dead902404f8c15dc0d00c4aaafbe9f66567f76"
    sha256 cellar: :any,                 x86_64_linux:  "aa8d7710ca0da8871ae8a7796bf63ade81433dd438af423089dada3318a56b86"
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
