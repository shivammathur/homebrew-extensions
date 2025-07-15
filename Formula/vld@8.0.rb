# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "466adf14acb5d3dc0fe7a0ad9029f55e623e20edaf07b7c72e756145771ca5a4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7cd72b9e05cd2c557f8bb9f44c3f01a80e11a26cc508a9e4b6dc8a6a21e56fed"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ba238a50d054aabe6e85b647860836bf633a104f3973e61607558dcca300a59e"
    sha256 cellar: :any_skip_relocation, ventura:       "137a7a408a497aa2d24e3a9fe88fbb0b5e5e4bfe5540609d371759872fe28ca0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d078ed3629d031c0e8622a1c15d26998b7dcf8a8d111dbbe9f03b3dbbdd3b296"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9186500a3bcf7b3e5ee1f3c736d549766816d21b25667a3498683b92da0eed1"
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
