# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT56 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2198435090caca788cd62d2799e4277dba05ea20f6e355d584b9c128ca8425f9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9c81319d52f31c7345f885d43a98692bebe2b0efa4fe95e35063a69c616386c3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "acebcbe3da800a66dd6be5dbab2fc6fd3e22a0e1f4a6b32c1e923d5afcaab063"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3eaf4e8a4e6ef6d24c1f919e75f6f86c392928c30afb87e2748cbff9bc2aa9c4"
    sha256 cellar: :any_skip_relocation, ventura:        "eb38598fd1a47611ff2a58d6362fcc22207a89c55a902a18d81584d02172275c"
    sha256 cellar: :any_skip_relocation, monterey:       "b2342ebc0db8a807495a1b80a94f0f8167c2aa9ff5a12c847d8fe100dc611c8e"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "038459876dccc602bf466462b9056002e5e0179966ab1d898ea5838870370898"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56505c6a74a2071217d755d2428cebedc644adddfca5ea2159d36d082543e341"
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
