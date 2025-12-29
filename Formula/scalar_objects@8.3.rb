# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a8718ea39b61ef77b1f7bd808e5a8468c8b2e2498d407023c10f6ac7adda1d4a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2f99facb3d35aede65b7a00ec9cf677665b97ec1d2b21e0771e7f31160ebeb00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "939d0d50496a3dc3f80042412251c784de8e710eb7748c76b684134125e37eb2"
    sha256 cellar: :any_skip_relocation, sonoma:        "26a50a992d0dede10f1fd4c1e27fc29ca7452ad1a8d16f39ea7a85c9801dd37e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de4ee1040b670163c8245a014af2a898b3309ac85d809b191879a028e4121bdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9ce39743877ac56c7ed88839c0a2ff57f479dd1058e3690d0573e448258e738"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
