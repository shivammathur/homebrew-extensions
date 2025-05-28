# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "083ed1788b7b0349d5f070e990053edad6472194e62eed947ef2a70b036a5e87"
    sha256 cellar: :any,                 arm64_sonoma:  "990bafd6b529f36c2aead795fbec4ddf8ffb60e82bc53fb7c4076dfad61a9ece"
    sha256 cellar: :any,                 arm64_ventura: "35e70df7d281e23777f774c7dac546b407a2cc245030f83b284cee082c63a8fb"
    sha256 cellar: :any,                 ventura:       "0ead663560f242f91d0ea9f0e0f5629f9f478e9b5447c3e70222dd9979dcdb99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9b4a121c5759b9e99167eb6a8a3ae24141ba0fc43f2b91ec8449a36327cf879e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec4a4613475f79d97636023218b58569a9f8c012963789b083a2e4cb9a956405"
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
