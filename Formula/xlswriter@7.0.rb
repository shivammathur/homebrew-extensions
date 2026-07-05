# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "47f788fe4f77eeeb1e4e53c0f28af272a043d527ff5ed212799736e2253d0045"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7d5b851ae2173414db8248e2b71d5dd23cd607eeb526ba78648bcf26637f7238"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "926b2070d38e8163bc2e8086b466cbc9fb241f6ee2e9c9ac569e527054aa004c"
    sha256 cellar: :any_skip_relocation, sonoma:        "09a7b5ec1d4f5f12503215167017219747f37d93835e7de9401cc37433f1c905"
    sha256 cellar: :any,                 arm64_linux:   "b7d761fd9c68e2b27e30fa45f3206150b8144e088d1fed541b7a3781e3b184ea"
    sha256 cellar: :any,                 x86_64_linux:  "ac7059d5b7f8470558f2bf07d42dc2c0b54dc1eada0aee524d797ce4dc62dd2f"
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
