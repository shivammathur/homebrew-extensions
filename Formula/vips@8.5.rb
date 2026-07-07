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
  revision 3
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "baefab1f6639740497503ac794a425f7bafc3aa016052c28944bdaa6b0556019"
    sha256 cellar: :any, arm64_sequoia: "1c9adf0c264ec23de3f63c2bd8dc6b68766462b9e18e71eefa6ae284a165334b"
    sha256 cellar: :any, arm64_sonoma:  "bd0f842bdab226020598e55a8d5586f47f3cda214eed6c0c8406ce1fd5dc3be9"
    sha256 cellar: :any, sonoma:        "763ec80fe8f31dd26cc96ac38f807f2aee9eb34a88083b827e75be600542b062"
    sha256 cellar: :any, arm64_linux:   "30fd6cde77d47424cdd9dfb466a083963ff2da7e676214a62e54e4136d1a7c7c"
    sha256 cellar: :any, x86_64_linux:  "3a5d3940f8075f8a064f252df63507f44429bb484966b53fa504e04a77c8e5ba"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Utils::Path.formula_opt_prefix("vips")}
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
