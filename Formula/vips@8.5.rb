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
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "9468df0da77f58d1e3f1be9b15eecd431b225c5c4b143475be4acf8f0df69096"
    sha256 cellar: :any,                 arm64_sonoma:  "4970df42bb57988030fac8ff248dbcfc805186d3b1dba51fdcc2458a31de9a5c"
    sha256 cellar: :any,                 arm64_ventura: "ecf6720f199709a18a7ff2a4cd348cc4cecbc780fbbcda3606b618b78e53d4f6"
    sha256 cellar: :any,                 ventura:       "d9688128a9234271d07b96826910e21d8b3300e8d1ef8c757cf39f2774303bcb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "be6b337bd695ac56f70a3893289813ec5d615fb3be25e23d08618f3f673811e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f941530e3b04f0574994b79ff162476c1623d2f6764628500c618c415c668899"
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
