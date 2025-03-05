# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e1f255bfd9e73a05258bfe7153f361545ac213cae0404bfc958428ca52fbb004"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2fe2dcf81f68f363575a963702c0d732b42529a8a9cadeea229186209499f0ae"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1612b419446b1e1f2d76ec03208bc816c48e6e538d4b56919ba6588cb35bcb98"
    sha256 cellar: :any_skip_relocation, ventura:       "5d06aa773a44b2f202e0702f5d01d532e2bacfdb945f6c757f593640c0af0c8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4db8d20dfd9e02c8006d4ffe86b423d62cab03bdb7bbcd8e319f4bf02f4b690a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
