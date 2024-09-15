# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT74 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "153e8967b427b9157100018a917bea53ea496b5517a7f6e10476a6de2782bf1e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "570dfb9b4091cbb18755787af94d79343fd72d4b1167ce0b7568cdab18cc99fb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c922202ee672994dd349727d0e2a825069f0f06a9d633216949ce000db554201"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4c426ebe9683d071fa9d20603ae5d55ff1c2582cf6d02228140478bf4a8d0654"
    sha256 cellar: :any_skip_relocation, ventura:        "a7c560c8e8d0289c176f7dc9599d7f491c34a16dc79bc3f948e43eb67375f360"
    sha256 cellar: :any_skip_relocation, monterey:       "d8376f460768febcc06ced11978662525bc001af2622530ffcafb7782e466d6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74653c836d099c60aecd72692e6257bb442b085b488d15f948d0bbdd1af38732"
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
