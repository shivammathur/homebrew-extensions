# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT72 < AbstractPhpExtension
  init
  desc "Scalar objects PHP extension"
  homepage "https://github.com/nikic/scalar_objects"
  url "https://github.com/nikic/scalar_objects/archive/86dbcc0c939732faac93e3c5ea233205df142bf0.tar.gz"
  sha256 "a0f621772b37a9d15326f40cc9a28051504d9432ba089a734c1803f8081b0b39"
  version "86dbcc0c939732faac93e3c5ea233205df142bf0"
  head "https://github.com/nikic/scalar_objects.git", branch: "master"
  license "MIT"

  livecheck do
    skip "No tagged releases; using latest commit"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ecd16ffbcd54bdb4526c57de17c35a5b703512351bc9ee83b37b7e1618f4c1a0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3d074769db6f224a9b0b5fd1e95d69449bef1a4cfcc365287f0313246f0850ad"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ccd40669f1b149600e71a95145eefaaabdc475639b42a854c5bdda605724252c"
    sha256 cellar: :any_skip_relocation, sonoma:        "f8cb6fd8ad53e05df6d4bdf5125799c2e5a735af21156b88b633a21435c5a15f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4aa4a4b9af9ca971837f03f495906af74f9f59a8514bf293d17e94be640aa2bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76fea1e38b2ee37cbbfddee5d532b518b83a7168f5bd3975a51b89fa2cc6ec96"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
