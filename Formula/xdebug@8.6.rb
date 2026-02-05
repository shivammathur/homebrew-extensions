# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8f05d5c11ff24a906b671f5427b3101afe80cc04.tar.gz"
  sha256 "f0d672291b5635aff2a7d99d160a7c418a9468c6c0e11540b6461ad48a45eab7"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256                               arm64_tahoe:   "7e77f253c353ce15f5e815771c0888dd1294e78f3b3ad02f0a19e182e9b04413"
    sha256                               arm64_sequoia: "06af5cb087d87101fa6c901991f86731c727550b7ecd1d30dec019c4a82a7667"
    sha256                               arm64_sonoma:  "6309d719eecc6e57888a41f800ccdaf9625d6d3d2820a9937f146bc5bce3bf41"
    sha256 cellar: :any_skip_relocation, sonoma:        "27485ecfceb224c47be0cb30a2351fe6f909496b4ecc5bb020908377741642e0"
    sha256                               arm64_linux:   "b63a2b06c9ecbff28120d2903532d69f8f38eff29d2fadb67df46f6b9d3fd1c7"
    sha256                               x86_64_linux:  "937704fcb1741aa22d8bdc9490173733c2da739387c79c07dc004dcd1f2e95da"
  end

  uses_from_macos "zlib"

  patch do
    url "https://github.com/shivammathur/xdebug/commit/13264e7ca3608026f710fb83c5f2314bdcc610e6.patch?full_index=1"
    sha256 "2c0ed06d8adcbdd534132bf4a30a8497a236b576d3dff4c92f1375ec0436f98b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
