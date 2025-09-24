# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT86 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d71d75bf2a904b8189dddd88f2b494d216266d53f49448ec238cc31ce4017c23"
    sha256 cellar: :any,                 arm64_sequoia: "7b2b677c1cc61905cb401526ac3056b7527bfde07781743f4ba9ee86eb746655"
    sha256 cellar: :any,                 arm64_sonoma:  "1167e0a14c9023e116f44ed7b255bee701012fd6f410b2404a14e2ff9eeedb6e"
    sha256 cellar: :any,                 sonoma:        "639c27703479fbf30f8b6cb775d8f5651080c0b8fd92ebf14379fac34c09e9ba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "61079e75392ae5982a4679589b7d78a4b297724cc9a1b46ba994fe69cb111cf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0fbcf4d3dc6d9a34d32292436c51464632112f3acd2b51322bd879e64f89f221"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
