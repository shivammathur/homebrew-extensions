# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT70 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.0.tar.gz"
  sha256 "4f591dc042540d1d6a7cf3438e4e70d001c2b981acd51b87ab87a286f26e282d"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6aee88d6d7128d9d1fb2a0a6e6e563415523c2cbc3ddfb9e93c1552f4c47f8c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7177a6217c1130ab286013241b46344596bb57a8e216470ed937a65c9bc56d14"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b605471ffe0c1e094ea54dc3374eb8fb2abcc87ee5874f6640af6395e86032d5"
    sha256 cellar: :any_skip_relocation, ventura:       "55fb575ff44fac33edc1a195507b7b7caedd230c5d347acb43d94ebb8b113f05"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a45fd719c407e3293d638ddeea798df8ebe44d4622df1d8cbf210aada8973f50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a85fbea3816a3289938b6450cf126cf4037fbfdb992940d2e8d06c420d81628"
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
