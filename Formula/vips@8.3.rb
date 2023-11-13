# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "b818a16c43f8dd204cb54ebe0133e3de04321641afd0126ffef6182977dd77a2"
    sha256 cellar: :any,                 arm64_ventura:  "530f0991ea59fc49281e872abb2e9ffbcd91a6ec2866c3ff2e7bba86c6c695d3"
    sha256 cellar: :any,                 arm64_monterey: "e3016e2431c714cdc2018bb9fc886c479b92873bff27f0388992d1b9134fdbba"
    sha256 cellar: :any,                 ventura:        "4b2146264e8ce2563e3a4b4cdf8eb1d6634d554326d3f08dba610752d3461904"
    sha256 cellar: :any,                 monterey:       "a222463961d03e9a17e80efb31898751b56e19165633ec74f013fbb501c2365d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c5b3ec1dbdc1aa2fc73e6e2c8842190a5b7da1cb71ae1a6681fb4f0a9693b78"
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
