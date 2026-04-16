# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0f4f79dd30797156b4e2b9cad712972d8b7591940fb5e19f32aa2618eb66b0e8"
    sha256 cellar: :any,                 arm64_sequoia: "793086fc1edc09dc7b34ce42b691babf6f01549c72c2136fba80d1f54ac1169b"
    sha256 cellar: :any,                 arm64_sonoma:  "eda24363cf018ddf15957876e34293e5c1ef8949db6dbb03634637f6be088602"
    sha256 cellar: :any,                 sonoma:        "4a006495116ba40150dc1613ea15b884f03c5b8e98f96acfd6b2d05fead26c52"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "11c4bf02f73f041d478c09726e859aefe54c3e71b8b1b7f7f9f0f54241467afd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33b89bbf42af6181e00c53091acfec0b84662a9bebd19cab053439059dd2a70d"
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
