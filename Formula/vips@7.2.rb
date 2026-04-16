# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "66b10ef3b15017fad87eea5ac075d3b04b9dedade1af1097f67dd62b4e902008"
    sha256 cellar: :any,                 arm64_sequoia: "8de1fea1c6cd41a20cd3cbb5507784181de66be3ab88aec176575b0a134e0062"
    sha256 cellar: :any,                 arm64_sonoma:  "c346f578b8b2975fa7178e5adb677d28d1dfa1e4bb5fd3329febc5c1374d7a07"
    sha256 cellar: :any,                 sonoma:        "d818a183999e17827d1868bf34430a0a2a19ddfb3eb3637746047f6c5c952a99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9625ae64b943c42787715b87c4460627f51ab567339155ec4d5cc0da14916a88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f150ed7ec56553e3904153932db6ec964660d3cf3615c82ed16160aea00e26ea"
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
