# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT84 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "c09711c159c9c8cdb7728ab5fb537d7527443ab3d5e63a622c34a4885bbc360a"
    sha256 cellar: :any,                 arm64_sonoma:   "6d37597207102277b038ae1a0656b5dccef00b36665cecbe5aca87b668b97c7b"
    sha256 cellar: :any,                 arm64_ventura:  "8ab857f7f152a329e5cf015bbdd901b3f210b81d952d17d873094a868147aae4"
    sha256 cellar: :any,                 arm64_monterey: "f9d3a8fc2064363c27ff352a464e5be227d79b140ecadd456d444134524e4375"
    sha256 cellar: :any,                 ventura:        "c121b42295179aba14e31f8825853f765a0e33debc3c4b61525222b206220d9c"
    sha256 cellar: :any,                 monterey:       "7fb7f089d61fd00c6cf4277255d9b650cbed3de0c56b9a0bbe4ca2885799091f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "67a149a491266155e75b60c3edc6c90f652bf5f4f862601b0b8dd57efc8fb5f0"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
