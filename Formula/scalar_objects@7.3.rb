# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2debe07ef484a881b0f42ba338ec2c2bcf035c3dd4be67cbf4f4af211a04904f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "126920e0f0c8c6425d77807d757f43813aa58bd05db166e83de78c0e9a2c8efd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e176bf395ca9248e29d404080610f82cd3d162a150f119839859ed6690745498"
    sha256 cellar: :any_skip_relocation, sonoma:        "3f753e58c919353abcd1c4afb5ad84a687536a8bb9bf362ae0944f0ae5450ef1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9b3a7d4d0420dce90601e0ad0db775897a15e6db23515f1d1bc6e6a638be02f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55d457dc6494d4d8e2d1f7b1c2cf7818ad6e2da615d84903525f19064ca7c0d1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
