# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT70 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f22d7a20a14657b2d6c8ce32021c811562fd8a1ea6904731b8aa328b862dcd8e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd27915d929f304d288d08e0377137efa5f5b71382fae44e13b42ab02e86a241"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ac5014ca39ddbddd9c00124da764655d2f13681dc44bf8e6cd7e3d1c31e23202"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a1f2fd4253af4d70cf34f3a4de8538df6de6a0257dd2bb73144ab7e91ea4619e"
    sha256 cellar: :any_skip_relocation, ventura:        "151b62bee9464636492f8d6526a99cfd305477b273278f0a3a4a22a949e7e7be"
    sha256 cellar: :any_skip_relocation, big_sur:        "ab5c8dc72a33bd6d701eb2808a94779284ca5315d2ad4b709b7af9305fb7fa31"
    sha256 cellar: :any_skip_relocation, catalina:       "0cf41782d5d48537bbe9335409f9b9e8771624591aa38c32634d1297fc171269"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "c52800cba956813a511cc6b23b93cf3443473c443c0576ab949fb2728402d62e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e09294c9125d48abfe14acd92278f0ef803dacfb5ed20fce4aecde39a8ddd02c"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.0"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
