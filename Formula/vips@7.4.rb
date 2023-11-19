# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "c351e2bdd2336e898334835873bd10d4873cecbc2e59fab09cdfefcfe31944d5"
    sha256 cellar: :any,                 arm64_ventura:  "b75015a6ce9266f2a8511f85e818e0b0f7fbe04871c799a52a88218b85f27ccf"
    sha256 cellar: :any,                 arm64_monterey: "d3ccac7c6bb30065d06698eeac0aa41cf10b28433d0c8ed1f06b6795db4fd0e5"
    sha256 cellar: :any,                 ventura:        "d2f60b6a1a94139d24aeb193649a6d1d334a1c7d1b8339d15a55d78dfe2e635d"
    sha256 cellar: :any,                 monterey:       "c8690c2ab383665a4994febf638e94a997205dfe4e786d7c4d720589a96ecea9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50da426cff17b6f36028bbe06c11da2d2b3f8aed8f27e537501b4ea073f5ef23"
  end

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
