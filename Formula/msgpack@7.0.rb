# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "e591562ad382a7c32450c131589b6290eae49b10a1951a224ab5a327ba7f9274"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "dabb69cc3127dbbdb0957b7ac204b91639b6d0cd561594394fa496916d2b7dda"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b1425b1766dc54b45ec8f97cd78bba08bd016240f5d10ab3d3a7559bac66a4f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d76f0cfe8fe67f5b65e15ebe16396ee04609345a5de22da198e36515fe8854d1"
    sha256 cellar: :any_skip_relocation, ventura:        "a9bd9a15c90fd7267e38aebaf78274cb3002a2509a4d25abc40686baffb0a58f"
    sha256 cellar: :any_skip_relocation, monterey:       "f4b97f0ac3319fd7f1cb75833a270f7d5dd8bad9e77b076ca864ae88ecdf6802"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a73b555d7723c2bdababe2f19feb9668fa5def71b615dcdb36583a4928e6671"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
