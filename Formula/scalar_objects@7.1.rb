# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "22ac4ae7b7db5bda746bd7e93401777fc0e5c24872bdecc50b7e0b1ccae3204d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fd1647e8ab07b1e15211368529d9a1ceb627e0c7b04d908ebcd1d1ea154c6c78"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b5996cc7269adb9b76e156ce8384360c7a59a0de681206d5c54ac894f61d90a"
    sha256 cellar: :any_skip_relocation, sonoma:        "26d6be9574929f58374bd65896aff635d7023579f06ae9ef5dd86092a21bc9b4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7e30a42656be08eadfad6455706270d7d5162e87f5e6b89626cbcebd9c35777c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc3f93a7d69b31b09bae114ca47c1574460f98384f81c07dfd97a5dbf6252df4"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
