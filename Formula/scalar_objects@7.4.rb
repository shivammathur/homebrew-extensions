# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for ScalarObjects Extension
class ScalarObjectsAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2ed974be0f73a995203ae98cdd8fba4e5411c99699b79f3e8bbfc99d9db18553"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "99a981158f936c20d0002d593a1b4b56e91ec0b98ca9cd867ef7affff22d7b0a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "81904083d9299bbbb3ef441451588cf405e02710393905ee4fb0a8a7aaf02012"
    sha256 cellar: :any_skip_relocation, sonoma:        "1e6b82412496fe4f88c96a3e91d1c6bf700f49c8c7783abe37b275238e4023bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7d642f0389cf6883980d3e5e9f7c5945d1f693e7a4583cf56fa36f3fa71bb914"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77b6ae9ec667dba69db2fa7136a2bbaab1529c264ba0f2478660cfe74394a1cc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
