# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "c0815f3e2fef7478a17214090070f227352adeeb0635a4fad734a416390a36e4"
    sha256 cellar: :any,                 arm64_sonoma:   "0d209735345d2f8f7360566ff61ecca91d34271216bd0af85e9b52fee87e8e15"
    sha256 cellar: :any,                 arm64_ventura:  "3987cff04bf9e066f9ae6dc8f492a7b8434247ad54acc80a8039430555a3714b"
    sha256 cellar: :any,                 arm64_monterey: "d94040a32efabab4966552b38861db024a2a1453d6935df6622950ad11e54ebe"
    sha256 cellar: :any,                 ventura:        "7361743da4ac14ce413af28c5ae3fd6d2cf836d41bf2c1ff9c919c2683fb2c41"
    sha256 cellar: :any,                 monterey:       "834e8e7c44d61c7f2f50a8a51a2a57579ee345454be37d6a0a1418f2c4632be1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "78908235805e3c9f136d30035bc0c7a2af7617606e005a04cfe7892b7e2116d2"
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
