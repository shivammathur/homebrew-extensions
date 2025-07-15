# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "413d3b43eeeee7a73c69e669775859add78026461d13d7fbecb4a41f49874b29"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "002e11548b379e45bfe83460283aecf7e83e6567db0cbf862f47767cf0de302f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "55164dbe53d3aed5f8dc08569c727530d7d7727e47466b02359a55f2b5c96155"
    sha256 cellar: :any_skip_relocation, ventura:       "5a7c145d934d2611052cce90c154d31dab797a9e37cf7da9d2ba53e444c4756b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ce38c1c3b6107ab41ccc2202feeea9d4ca70bc9cfdcf5bb6c49ef2fdf9f8a11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e48283cf1324ada423588298b5fa375156258f0bf99547f08602e38b158c7638"
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
