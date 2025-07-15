# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT71 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "118073928e108bafe98bd539a3ec39843fbb67537dac0f2b01078a7e4e66ff7c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1f07460134ef732e6fd00e38d8c8156ad271fbffc595653d6d755f718a4e9528"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9b90e2bb6da1fcc76a7ccfcd59bacb126ef770c99caa4d4e131456ae4a9bb749"
    sha256 cellar: :any_skip_relocation, ventura:       "b66107976a43f55c5f9e27fa64ed95282b271d94b3de8aa6b3856598f07189d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "37b0f26ea1ca0971f8aaa2bcdd4c77b337213adc4838a2aa4c7bb978021d82eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e6642da1d3f2bd54f913a7ea62a63ffda9a38d1fd78e86252dd0732c2677fd2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
