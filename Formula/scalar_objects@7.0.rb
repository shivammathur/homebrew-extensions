# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bcb26575e73711b6007e37ddd2e5dfe047fdbe3b254e438fb40c94b958464b93"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c7aefc5922850ba90e0db1e0b4871e392e477ec5ebff8e234c209a66703cba94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d72aa6087c428fad2fb9203d609807c3cb9e74f3237a14968bd18fded426090a"
    sha256 cellar: :any_skip_relocation, sonoma:        "63216225ae6e962781b822ae4561ba859414e374fcd45d09bdad9b998843ea18"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "db6247e83b1f531985cb584a605ab0b37846acb8f6d632edaa1d678d2fcbffc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c866465dfa6d84678458c43aaab96bfd765b82c9bf5d713a02cdb626d3a09e3b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
