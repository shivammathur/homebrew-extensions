# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT85 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "756702498c6586023cbdc352dd2619f3e3627113f89f1b0b423d265b6c4cd01a"
    sha256 cellar: :any,                 arm64_sequoia: "2f84c54d58767da4db170ef564eacc2505debbffe15851fa0d801f611dbbe00a"
    sha256 cellar: :any,                 arm64_sonoma:  "4ac26c4a3428832540abe58441cc2ee0d3930a426142bd54d700d5d4a2a3c897"
    sha256 cellar: :any,                 sonoma:        "2e44313c49b9773bed5fc51c460fb9c4bd8efcc0d5095e2f802c5cab89676fbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e638794d8d6b83ea719d0cf7c9dfcfa8531539e6b6efe6a7cf890208c7390071"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9929b6faa0beb3f32b0a4896da49b3e049a0fcb74c01c1dc791a8cc3508f15dc"
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
