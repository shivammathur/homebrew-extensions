# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "85c42a1bf37984498d3813844ed46b5be07cf8c4c4601b53be6609fcf554b323"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9fca2d40211f1ae43a76edc2dedb395dd33a3cc238ec10eec409eb2efd7e6bc9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6b72f15fa72e2dedaf5d5dd428881486688003698ee1301faf230071fa4dc06a"
    sha256 cellar: :any_skip_relocation, sonoma:        "150ee5a896cf1ec8c65d1dacd97ebc0f4ffc8d1f9907452e8d8bd5ad10038e0d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5be2137630b6541493af74a1de4d6c2e5edb9611d4bb8c2fc5e2a0fc4e7dd732"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "981d114d799c3478f79914b8f3050c4f8ee46468739183f3719638de9c65edf2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
