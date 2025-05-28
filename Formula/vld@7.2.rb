# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT72 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "13e8cf716bd0bb17710a41d4c58585650a978c83f1ddd2846a39252d94f3fddc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9767647dbbc3e993b951ae88f93aa29989809eecf6bfddc2816a8e38b74beed0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "704efbc01c129688533d02ff0ae075bd385f3ed96429d4c6743e4e0fa394a73d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "273c4bf57c197cdd0f5b92cb9fd4e42ecb71dae584f9ba3203b8b380361ff1ce"
    sha256 cellar: :any_skip_relocation, ventura:        "3520760fc0b429aba243c6c3ff431f351a9115c20bc2ee8096cba3f3f9c22c20"
    sha256 cellar: :any_skip_relocation, monterey:       "5464bfc7d9bd1dd9c1ee4f9672e8384ce8a8c8292a22ef7794fee17596b54fd0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "6aea7bf97950c17d1abe0bbdb27acd8df8f98a36e713eac012943059dcfd7257"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6cd390d3e2bfa8ac8edad5790782bcbbe9e296d2385a275ffc7d9c71c3aff4e7"
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
