# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "0b0b1bfcdc5e5647c5796941ad362ea0713494de00fe2a6dd9e92ea709d3ce02"
    sha256 cellar: :any,                 arm64_ventura:  "45f500b3338beae03063d233506c153aaedc27ab1e663ce8b92afe4aa310f50a"
    sha256 cellar: :any,                 arm64_monterey: "35b43a0d7045234a42a28d1493f1db6d6e306db3bbd794c12b128ee550eb6a49"
    sha256 cellar: :any,                 ventura:        "185344d73dce068c7dbaf74f16f426bcab7c39194755ac181506405ddf842409"
    sha256 cellar: :any,                 monterey:       "4133e2525efeabf0a6df209a043a4c821c6b94c8c6554791df1c7e67e83cf5c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "796e6a41369ccdeaceda0d1cd21317b609ef1c6dd0e7d7d098c4e4d7c854f241"
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
