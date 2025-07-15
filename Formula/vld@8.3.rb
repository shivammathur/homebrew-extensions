# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "72e9d9fe2ee2c662a07799908b8677a9c7cf1ecb6b206822d2809eea11c830c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "26eadad29662eb6a256dc659ced4620fe93a8d65353ec1a2af4ab3bfc91129fa"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b206572e186668bcb562bb58a9a60cc90bba7cc348bfbc26a453bd93de5fb069"
    sha256 cellar: :any_skip_relocation, ventura:       "4fa8bc1c6245302280df71bb76830ebdcdf8935879dd15ada524f79b5d17d236"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a410095cb1a49af2b288b3ab245b609cf559666e084ce67d11fe2c5f5a689f35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6621976e2527bfdc627777da03684439de9e2fa18a57f790509c8b9dd73fdadc"
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
