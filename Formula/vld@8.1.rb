# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ca8d55f44d8cb02c3709fc4edcc2ee170b22940414214b04f708074cbb9131f9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2560afae9c848bb6c00f614f1502edf718fa7b62f1458bd2b475b0827d990588"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "818fe815c0f91529f36d5a4b84e367e4d4dacbc0e8df94a29567d8cf4915b21f"
    sha256 cellar: :any_skip_relocation, ventura:       "af658830a5e37bce8d8360ca94a183ca46e3c14a54c7eb84e6d4cf0cc1dfbca4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "75ae33d05e00c31509fabe3b69db05f10ead42da906e81f132a465ca7c23b47a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aba93a922134745340e12aa441aa505457b5269e544ae29f90e180889eeb9ad6"
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
